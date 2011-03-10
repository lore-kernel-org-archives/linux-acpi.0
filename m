From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Patch] acpi: introduce "acpi_addr=" parameter for kdump
Date: Thu, 10 Mar 2011 09:50:28 -0800
Message-ID: <m1oc5ig90b.fsf@fess.ebiederm.org>
References: <1299766243-494-1-git-send-email-amwang@redhat.com>
	<20110310143923.GB29464@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110310143923.GB29464@redhat.com> (Vivek Goyal's message of
	"Thu, 10 Mar 2011 09:39:23 -0500")
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Amerigo Wang <amwang@redhat.com>, linux-kernel@vger.kernel.org, Takao Indoh <tindoh@redhat.com>, Randy Dunlap <rdunlap@xenotime.net>, Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-acpi@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Thu, Mar 10, 2011 at 10:10:43PM +0800, Amerigo Wang wrote:
>> From: Takao Indoh <tindoh@redhat.com>
>> 
>> There is a problem with putting the first kernel in EFI virtual mode,
>> it is that when the second kernel comes up it tries to initialize the
>> EFI again and once we have put EFI in virtual mode we can not really
>> do that.
>> 
>> Actually, EFI is not necessary for kdump, we can boot the second kernel
>> with "noefi" parameter, but the boot will mostly fail because 2nd kernel
>> cannot find RSDP.
>> 
>> In this situation, we introduced "acpi_addr=" kernel parameter,
>> so that kexec-tools can pass the "noefi acpi_addr=X" to the second kernel
>> to make kdump works.
>> 
>
> Little more background on this. So we now seem to have this general
> general problem of how to make kexec/kdump work with EFI.
>
> I have very limited knowledge of EFI and based on some information
> gleaned, it looks we seem to have two alternatives to make kdump work.
>
> - Don't transition to virtual mode in first kernel and work with
>   physical mode of EFI. Maintain a separate set of page tables for
>   mapping EFI and use those to make EFI calls.
>
> - Transition EFI in virtual mode in first kernel. Boot second kernel with
>   "noefi" and pass in whatever details are required on kernel command line.
>   One such details is ACPI pointer.
>
> Matthew Garret mentioned that other OSes tend to transition EFI in
> virtual mode (MacOS X seems to be the exception) and if we decide to stick
> to physical mode all the time then we can expect a host of BIOS bug report
> as vendors are unlikely to test that path.
>
> Keeping in that mind, using noefi for second kernel make sense. But
> I think it is not good for pure kexec case. Takao Indoh san mentioned
> that he seems to be running into VGA initialization issues and it
> seems there is a need to pass SMBIOS address also.
>
> So I think if it work, for kdump case probably using noefi is fine. I
> wanted to bring up the case of kexec and wondering how to make it 
> work with virtual mode of EFI or what is our strategy to handle it.
>
> Eric and others, any thoughts on this in general?

If we want to handle EFI in a long term supportable manner and stop
making short term hacks here is my suggestion.

Move all EFI calls that the kernel does (on x86) into a special section
of the bzImage that the bootloader can run.  This works very well for
the x86 BIOS and it should also work very well for EFI.  Among other
things by having a special 32bit and a special 64bit section this solves
the what flavor of EFI problem are we running on problem.

Never perform any EFI calls once the kernel is initialized, last I
looked all of the EFI calls that were interesting to perform at runtime
were a subset of what ACPI can do, and ACPI is a easier to deal with
long term.

Kexec and kdump can easily pass the gather data from the first kernel to
the second kernel like we do for the normal bios paramsters today.

As a fly in the ointment that leaves the question of how do we set EFI
variables.  It is needed functionality when we are installing, and
occasionally nice to have.  But it is a very rare slow path.  I would
isolate the EFI after the kernel has booted to exactly to that one case.
Either with a special driver or a some flavor of virtualization from
userspace like we used to do for video card initialization.

The current design of EFI in the x86 kernel is crap.  We seem to have
advanced past the early adopter hack anything together to make it work
stage.  So let's stop adding hacks and write something that won't give
us a long term support problems.

Eric
