From: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Subject: [Test_Module] Changing brightness in Toshiba notebooks with Phoenix
 Bios
Date: Fri, 15 Jun 2007 09:23:12 -0300
Message-ID: <467284B0.4090407@mandic.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-02.mandic.com.br ([200.225.81.133]:45017 "EHLO
	smtp-02.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbXFOMXb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jun 2007 08:23:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jonathan@buzzard.me.uk, john@neggie.net, linux-acpi@vger.kernel.org

This module below work fine in some tested laptops with Phoenix BIOS.

And omnibook driver available in [1] work fine in some laptops with=20
TOSHIBA BIOS is not recognized by toshiba_acpi.

[1]:
svn export https://svn.sourceforge.net/svnroot/omnibook/omnibook/trunk

=46orwarding from: Toshiba_Linux-Users (tlinux-users@linux.toshiba-dme.=
co.jp)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
To compile:
Edit a Makefile and add:
   obj-m :=3D test.o

then run in the same directory:

  make -C /usr/src/linux SUBDIRS=3D`pwd` modules

Then make the file for the new device:

  mknod test_file c 181 0

Load de module:

  insmod test.ko

And now, if you are very very lucky, maybe it will work:

   echo 3 > test_file

But I warn: THE MOST PROBABLY THING WILL HAPPEN IS THE FREEZE OF THE
LAPTOP IF YOUR MODEL DOESN'T MATCH EXACTLY WITH THE MODEL I TESTED. If
you don't have a Phoenix BIOS don't try this, and if you have.. well..
it's your election x)

Here is the driver

test.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D CUT HERE =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
/*
* Module for Toshiba lcd bright change.
* I only made it for my Toshiba Satellite Pro A100 with Phoenix BIOS
* I don't know under which models it works (I suppose very few)
* The asm code I inserted I took it from a disass of the windows
* driver provided by Toshiba.
* WARNING:
* The driver does NOT make any tests if the model is valid or not
* so, the MOST probably effect of running this will be the hang of
* the laptop, or something worse.
* PLEASE DON'T USE THIS unless you really know what you are doing
* This module isn't made for give support to any Toshiba model,
* only for tests purpouses , sorry about it.
*
* Jaime F. <jaimeff@gmail.com>
* License: GNU/GPL
*/


#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/fs.h>
#include <linux/io.h>

#define DEVICE_NAME "lcd_bright"
#define MAJOR_NUM 181

char *ptr;

static ssize_t
device_write(struct file *file,
             const char __user * buffer, size_t length, loff_t * offset=
)
{
  char *addr;
  addr=3D(char *)__pa(ptr);
  addr+=3D0x10;

  strcpy(ptr, "INVTOS");
  //ptr+=3D10;
  *(ptr+16)=3D(char) buffer[0]-0x30;
  //printk("escribiendo %x\n", *ptr);
/*
  inb( 0x2e);
  inb( 0x2f);
  outb(7, 0x2e);
  outb(9, 0x2f);
  v3=3Dinb(0x2f);
  outb2(0x2e, 0x55);
  outb2(0x2e, 7);
  outb2(0x2f,0x10);
  outb2(0x2e,0xe0);
  v4=3Dinb(0x2f);
  outb2(0x2f,2);
  v5=3Dinb(0x2f);
  outb2(0x2f,3);

  outb2(0x2e, 7);
  outb2(0x2f,9);
  outb2(0x2e,0x60);
  v1=3Dinb(0x2f);
  outb2(0x2e,7);
  outb2(0x2f,0x10);
  outb2(0x2e,0xe0);
  outb2(0x2f,0);
  outb2(0x2e, 7);
  outb2(0x2f, 9);
  outb2 ( 0x2e, 0xaa);
  outb2 ( 0x400, 0xAF);
  v2=3Dinb( 0x401);
  outb2( 0x400, 0xAF);
*/

  __asm__("cli\n"
        /*        "mov $0x01E4, %%eax\n"
                  "mov $0x00b0, %%dx\n"
                  "movb $0x02, 0xEF\n"
                  "out %%eax, %%dx\n"
*/
                "mov %0, %%edx\n"
                "mov %%edx, %%edi\n"
                "mov $0x20, %%ecx\n"
                "mov $0x8000f840, %%eax\n mov $0xcf8, %%edx\n out %%eax=
,
%%dx\n"
                "mov $0xcfc, %%dx\n"
                "in %%dx, %%eax\n"
                "and $0x0000ff80, %%eax\n"
                "add $0x2c, %%eax\n"
                "mov %%ax, %%dx\n"
                "in %%dx, %%eax\n"
                "push %%eax\n"
//              "mov %%ax, %%dx\n"
                "xor %%eax, %%eax\n"
                "out %%eax, %%dx\n"
                "mov $0xA2E4, %%eax\n"
                "mov $0xb2, %%dx\n"
                "out %%eax, %%dx\n"
                "pop %%eax\n"
                "mov $0x102c, %%dx\n"
                "out %%eax, %%dx\n"
/*              "movl $0x10, %%edx\n\t"
                "movl %%edx, %%edi\n\t"
                "movl $0x20, %%ecx\n"
                "movw  $0x00E4, %%ax\n"
                "movb  $0x5, %%ah\n"
                "outw  %%ax, $0xb2\n"
                "movl %%eax, %0\n sti\n"
                */
        :
        :"r"(addr): "%eax", "%edx", "%ecx","%edi", "%esi");
  return length;
}

struct file_operations Fops =3D {
  .write =3D device_write,
};

int init_module()
{
  int ret_val;
  ptr=3D(char *)kmalloc(100, GFP_KERNEL);
  ptr+=3D10;
  ret_val =3D register_chrdev(MAJOR_NUM, DEVICE_NAME, &Fops);

  if (ret_val < 0)
  {
    printk(KERN_ALERT "El registro del dispositivo fall=F3 (%d)\n", ret=
_val);
    return ret_val;
  }

return 0;
}

void cleanup_module()
{
  int ret;

  ret =3D unregister_chrdev(MAJOR_NUM, DEVICE_NAME);

  if (ret < 0)
    printk(KERN_ALERT "Error: unregister_chrdev: %d\n", ret);
}

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D CUT HER=
E =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Best Regards,
Renato S. Yamane
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
