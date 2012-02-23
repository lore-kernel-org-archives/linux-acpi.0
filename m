From: Tang Liang <liang.tang@oracle.com>
Subject: [PATCH 0/5] xen: patches for supporting efi
Date: Thu, 23 Feb 2012 17:11:23 +0800
Message-ID: <1329988283-26722-1-git-send-email-liang.tang@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: mjg59@srcf.ucam.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, konrad.wilk@oracle.com, JBeulich@suse.com
Cc: liang.tang@oracle.com
List-Id: linux-acpi@vger.kernel.org

Hi

The following patches introduce and implement efi support in dom0.
The efi memory is owned by Xen and efi run-time service can not be called 
directly in dom0, so a new efi driver is needed by Xen efi. 
These patches are based on v3.3.0-rc2+. 

Descriptions for these patches:

The efi public functions are changed to function pointers in efi_init_funcs 
struct. They act as efi generic functions as default. 
As a benefit from this change, we can register xen efi init func. 

In order to add xen efi video support, it is required to add xen-efi's 
new video type(XEN_VGATYPE_EFI_LFB) case handler in the function xen_init_vga 
and set the video type to VIDEO_TYPE_EFI to enable efi video mode. 

I have tested this patch on Dell Opti 790.

Xen efi boot support is added by Jan Beulich, more detail information can be 
gotten from the url: 
http://wiki.xen.org/xenwiki/XenParavirtOps, search "efi" in the page.

The example of config file for efi boot:
kernel=vmlinuz-3.3.0-rc2+ root=xx ro console=tty0
ramdisk=initramfs-3.3.0-rc2+.img
video=gfx-x.0 

The detailed test which i have done: 
First, Check efifb driver work well or not and check the kernel messesge ro
see the follow info:
[    0.576705] efifb: probing for efifb
[    0.577357] efifb: framebuffer at 0xd0000000, mapped to 0xffffc90005800000, using 3752k, total 65472k
[    0.577360] efifb: mode is 800x600x32, linelength=3200, pages=1
[    0.577362] efifb: scrolling: redraw
[    0.577364] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0 

Second, Check efi systab and variable is work well or not. 
cat the information in /sys/firmware/efi to check the efi systab and variable 
is right or not. 
 
Third, Run Linux firmware testing tools which is downloaded from this Url.
http://linuxfirmwarekit.org/download.php 

Jan Beulich (1):
      EFI: add efi driver for Xen efi

Tang Liang (4):
      EFI: Provide registration for efi_init.. etc efi public      function
      EFI: seperate get efi table info code to single function
      Xen efi: Add xen efi enabled detect
      Xen vga: add the xen efi video mode support

 arch/x86/platform/efi/Makefile   |    2 +-
 arch/x86/platform/efi/efi-xen.c  |  460 ++++++++++++++++++++++++++++++++++++++
 arch/x86/platform/efi/efi.c      |   63 +++++-
 arch/x86/xen/enlighten.c         |    3 +
 arch/x86/xen/vga.c               |    7 +
 include/linux/efi.h              |   14 +-
 include/xen/interface/platform.h |  122 ++++++++++
 include/xen/interface/xen.h      |    1 +
 8 files changed, 665 insertions(+), 7 deletions(-)

Thanks
Liang.
-- 
1.7.7.5
