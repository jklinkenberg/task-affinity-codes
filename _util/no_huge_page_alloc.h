/*
 * Special memory allocation that will prohibit usage of transparent huge pages
 */

#include <linux/mman.h>
#include <malloc.h>

#define MEM_ALIGNMENT        4096

static inline void* alloc(size_t size)
{
  void* p = memalign(MEM_ALIGNMENT, size);
  madvise(p, size, MADV_NOHUGEPAGE);
  return p;
}

