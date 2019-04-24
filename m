From: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 09/63] Documentation: ACPI: move
 method-customizing.txt to firmware-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 00:28:52 +0800
Message-ID: <20190424162850.g5ripuixdkvvzsjm@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-10-changbin.du@gmail.com>
 <20190423180316.7f042bc4@coco.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190423180316.7f042bc4@coco.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Changbin Du <changbin.du@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 23, 2019 at 06:03:16PM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 24 Apr 2019 00:28:38 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  Documentation/acpi/method-customizing.txt     | 73 -----------------
> >  Documentation/firmware-guide/acpi/index.rst   |  3 +-
> >  .../acpi/method-customizing.rst               | 82 +++++++++++++++++++
> >  3 files changed, 84 insertions(+), 74 deletions(-)
> >  delete mode 100644 Documentation/acpi/method-customizing.txt
> >  create mode 100644 Documentation/firmware-guide/acpi/method-customizing.rst
> > 
> > diff --git a/Documentation/acpi/method-customizing.txt b/Documentation/acpi/method-customizing.txt
> > deleted file mode 100644
> > index 7235da975f23..000000000000
> > --- a/Documentation/acpi/method-customizing.txt
> > +++ /dev/null
> > @@ -1,73 +0,0 @@
> > -Linux ACPI Custom Control Method How To
> > -=======================================
> > -
> > -Written by Zhang Rui <rui.zhang@intel.com>
> > -
> > -
> > -Linux supports customizing ACPI control methods at runtime.
> > -
> > -Users can use this to
> > -1. override an existing method which may not work correctly,
> > -   or just for debugging purposes.
> > -2. insert a completely new method in order to create a missing
> > -   method such as _OFF, _ON, _STA, _INI, etc.
> > -For these cases, it is far simpler to dynamically install a single
> > -control method rather than override the entire DSDT, because kernel
> > -rebuild/reboot is not needed and test result can be got in minutes.
> > -
> > -Note: Only ACPI METHOD can be overridden, any other object types like
> > -      "Device", "OperationRegion", are not recognized. Methods
> > -      declared inside scope operators are also not supported.
> > -Note: The same ACPI control method can be overridden for many times,
> > -      and it's always the latest one that used by Linux/kernel.
> > -Note: To get the ACPI debug object output (Store (AAAA, Debug)),
> > -      please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".
> > -
> > -1. override an existing method
> > -   a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
> > -      just run "cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat"
> > -   b) disassemble the table by running "iasl -d dsdt.dat".
> > -   c) rewrite the ASL code of the method and save it in a new file,
> > -   d) package the new file (psr.asl) to an ACPI table format.
> > -      Here is an example of a customized \_SB._AC._PSR method,
> > -
> > -      DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
> > -      {
> > -	Method (\_SB_.AC._PSR, 0, NotSerialized)
> > -	{
> > -		Store ("In AC _PSR", Debug)
> > -		Return (ACON)
> > -	}
> > -      }
> > -      Note that the full pathname of the method in ACPI namespace
> > -      should be used.
> > -   e) assemble the file to generate the AML code of the method.
> > -      e.g. "iasl -vw 6084 psr.asl" (psr.aml is generated as a result)
> > -      If parameter "-vw 6084" is not supported by your iASL compiler,
> > -      please try a newer version.
> > -   f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
> > -   g) override the old method via the debugfs by running
> > -      "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
> > -
> > -2. insert a new method
> > -   This is easier than overriding an existing method.
> > -   We just need to create the ASL code of the method we want to
> > -   insert and then follow the step c) ~ g) in section 1.
> > -
> > -3. undo your changes
> > -   The "undo" operation is not supported for a new inserted method
> > -   right now, i.e. we can not remove a method currently.
> > -   For an overridden method, in order to undo your changes, please
> > -   save a copy of the method original ASL code in step c) section 1,
> > -   and redo step c) ~ g) to override the method with the original one.
> > -
> > -
> > -Note: We can use a kernel with multiple custom ACPI method running,
> > -      But each individual write to debugfs can implement a SINGLE
> > -      method override. i.e. if we want to insert/override multiple
> > -      ACPI methods, we need to redo step c) ~ g) for multiple times.
> > -
> > -Note: Be aware that root can mis-use this driver to modify arbitrary
> > -      memory and gain additional rights, if root's privileges got
> > -      restricted (for example if root is not allowed to load additional
> > -      modules after boot).
> > diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> > index 61d67763851b..d1d069b26bbc 100644
> > --- a/Documentation/firmware-guide/acpi/index.rst
> > +++ b/Documentation/firmware-guide/acpi/index.rst
> > @@ -10,5 +10,6 @@ ACPI Support
> >     namespace
> >     enumeration
> >     osi
> > +   method-customizing
> >     DSD-properties-rules
> > -   gpio-properties
> > +   gpio-properties
> > \ No newline at end of file
> > diff --git a/Documentation/firmware-guide/acpi/method-customizing.rst b/Documentation/firmware-guide/acpi/method-customizing.rst
> > new file mode 100644
> > index 000000000000..32eb1cdc1549
> > --- /dev/null
> > +++ b/Documentation/firmware-guide/acpi/method-customizing.rst
> > @@ -0,0 +1,82 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=======================================
> > +Linux ACPI Custom Control Method How To
> > +=======================================
> > +
> > +:Author: Zhang Rui <rui.zhang@intel.com>
> > +
> > +
> > +Linux supports customizing ACPI control methods at runtime.
> > +
> > +Users can use this to:
> > +
> > +1. override an existing method which may not work correctly,
> > +   or just for debugging purposes.
> > +2. insert a completely new method in order to create a missing
> > +   method such as _OFF, _ON, _STA, _INI, etc.
> > +
> > +For these cases, it is far simpler to dynamically install a single
> > +control method rather than override the entire DSDT, because kernel
> > +rebuild/reboot is not needed and test result can be got in minutes.
> > +
> > +.. note:: Only ACPI METHOD can be overridden, any other object types like
> > +   "Device", "OperationRegion", are not recognized. Methods
> > +   declared inside scope operators are also not supported.
> > +.. note:: The same ACPI control method can be overridden for many times,
> > +   and it's always the latest one that used by Linux/kernel.
> > +.. note:: To get the ACPI debug object output (Store (AAAA, Debug)),
> > +   please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".
> 
> Hmm... this may work (not sure if Sphinx would warn or not), but it
> is visually bad on text mode. I would code it, instead, with something 
> like:
> 
> .. note::
> 
>     - Only ACPI METHOD can be overridden, any other object types like
>       "Device", "OperationRegion", are not recognized. Methods
>       declared inside scope operators are also not supported.
> 
>     - The same ACPI control method can be overridden for many times,
>       and it's always the latest one that used by Linux/kernel.
> 
>     - To get the ACPI debug object output (Store (AAAA, Debug)),
>       please run::
> 
> 		echo 1 > /sys/module/acpi/parameters/aml_debug_output
> 
> As this would make it visually better on both text and html formats.
>
No warnings given. Your suggested style is better so applied it. Thanks!

> > +
> > +1. override an existing method
> > +==============================
> > +a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
> > +   just run "cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat"
> > +b) disassemble the table by running "iasl -d dsdt.dat".
> > +c) rewrite the ASL code of the method and save it in a new file,
> > +d) package the new file (psr.asl) to an ACPI table format.
> > +   Here is an example of a customized \_SB._AC._PSR method::
> > +
> > +      DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
> > +      {
> > +         Method (\_SB_.AC._PSR, 0, NotSerialized)
> > +         {
> > +            Store ("In AC _PSR", Debug)
> > +            Return (ACON)
> > +         }
> > +      }
> > +
> > +   Note that the full pathname of the method in ACPI namespace
> > +   should be used.
> > +e) assemble the file to generate the AML code of the method.
> > +   e.g. "iasl -vw 6084 psr.asl" (psr.aml is generated as a result)
> > +   If parameter "-vw 6084" is not supported by your iASL compiler,
> > +   please try a newer version.
> 
> I would use ``iasl -vw 6084 psr.asl`` and ``-vw 6084``.
> 
> > +f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
> 
> I would do:
> 
>    f) mount debugfs by running::
> 
> 	mount -t debugfs none /sys/kernel/debug
> 
> As it makes a better html document. I believe that the focus here is
> sysadmins. Doing the above makes easier for them to cut and paste
> commands.
> 
> > +g) override the old method via the debugfs by running
> > +   "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
> 
> Same applies here: I would also place the "cat" command on a literal
> block.
> 
> > +
> > +2. insert a new method
> > +======================
> > +This is easier than overriding an existing method.
> > +We just need to create the ASL code of the method we want to
> > +insert and then follow the step c) ~ g) in section 1.
> > +
> > +3. undo your changes
> > +====================
> > +The "undo" operation is not supported for a new inserted method
> > +right now, i.e. we can not remove a method currently.
> > +For an overridden method, in order to undo your changes, please
> > +save a copy of the method original ASL code in step c) section 1,
> > +and redo step c) ~ g) to override the method with the original one.
> > +
> > +
> > +.. note:: We can use a kernel with multiple custom ACPI method running,
> > +   But each individual write to debugfs can implement a SINGLE
> > +   method override. i.e. if we want to insert/override multiple
> > +   ACPI methods, we need to redo step c) ~ g) for multiple times.
> > +
> > +.. note:: Be aware that root can mis-use this driver to modify arbitrary
> > +   memory and gain additional rights, if root's privileges got
> > +   restricted (for example if root is not allowed to load additional
> > +   modules after boot).
> 
> Same comment as above: IMHO, having a single note block with the two
> notes would be better.
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
