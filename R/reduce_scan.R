#' @title Reduction of Scan Dimensions from Mask
#' @description Reduces the dimensions of a scan based on extent of
#' a mask. Combines
#' \code{\link{getEmptyImageDimensions}} and
#' \code{\link{applyEmptyImageDimensions}}.
#'
#' @param img Image to reduce
#' @param mask Mask to reduce image by
#'
#' @return List of antsImage objects for reduced image and mask
#' @export
#'
#' @import methods
#' @importFrom extrantsr check_ants
#' @importFrom neurobase mask_img
#' @importFrom neurobase getEmptyImageDimensions applyEmptyImageDimensions
reduce_scan = function(img, mask) {
  img = check_ants(img)

  mask = check_ants(mask)
# mask = as.array(mask)

  inds = getEmptyImageDimensions(mask)

  drop_img = applyEmptyImageDimensions(img = img,
                                       inds = inds)
  drop_mask = applyEmptyImageDimensions(img = mask, inds = inds)

  # drop_img = as.antsImage(drop_img)
  # drop_img = antsCopyImageInfo(img, drop_img)

  # drop_mask = as.antsImage(drop_mask)
  # drop_mask = antsCopyImageInfo(img, drop_mask)

  drop_img = mask_img(drop_img, drop_mask)
  L = list(img = drop_img,
           mask = drop_mask)
  return(L)
}