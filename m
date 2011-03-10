From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [Patch] acpi: introduce "acpi_addr=" parameter for kdump
Date: Thu, 10 Mar 2011 18:50:19 +0000
Message-ID: <20110310185019.GB23105@srcf.ucam.org>
References: <1299766243-494-1-git-send-email-amwang@redhat.com> <20110310143923.GB29464@redhat.com> <m1oc5ig90b.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <m1oc5ig90b.fsf@fess.ebiederm.org>
Sender: linux-doc-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Amerigo Wang <amwang@redhat.com>, linux-kernel@vger.kernel.org, Takao Indoh <tindoh@redhat.com>, Randy Dunlap <rdunlap@xenotime.net>, Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 10, 2011 at 09:50:28AM -0800, Eric W. Biederman wrote:

> Move all EFI calls that the kernel does (on x86) into a special section
> of the bzImage that the bootloader can run.  This works very well for
> the x86 BIOS and it should also work very well for EFI.  Among other
> things by having a special 32bit and a special 64bit section this solves
> the what flavor of EFI problem are we running on problem.

There's no benefit in calling any EFI methods in the kernel if we have 
no intention of making further calls later. If we intent on making 
further calls later then this approach doesn't work well.

> Never perform any EFI calls once the kernel is initialized, last I
> looked all of the EFI calls that were interesting to perform at runtime
> were a subset of what ACPI can do, and ACPI is a easier to deal with
> long term.

With the exception of reboot, I don't see any overlap between the EFI 
runtime services and ACPI.

> Kexec and kdump can easily pass the gather data from the first kernel to
> the second kernel like we do for the normal bios paramsters today.

Doing that's not a problem. The real problem is that passing a virtual 
map to EFI is a one-shot event. The information we need to provide to 
the second kernel isn't a set of parameters - it's the whole memory map, 
and we need to depend on the kernel to be able to set up the same map 
again.

> As a fly in the ointment that leaves the question of how do we set EFI
> variables.  It is needed functionality when we are installing, and
> occasionally nice to have.  But it is a very rare slow path.  I would
> isolate the EFI after the kernel has booted to exactly to that one case.
> Either with a special driver or a some flavor of virtualization from
> userspace like we used to do for video card initialization.

Also capsule updating (not that we implement that at present, but 
vendors will want it). But, again, if you want to push this out to some 
sort of magic then we can just drop pretty much all of the kernel EFI 
support.

> The current design of EFI in the x86 kernel is crap.  We seem to have
> advanced past the early adopter hack anything together to make it work
> stage.  So let's stop adding hacks and write something that won't give
> us a long term support problems.

We're using EFI exactly as it's designed to be used at the moment. The 
only problem is that nobody ever thought people would try to do anything 
like booting one OS into another OS that has different ideas about 
address space layout, but that's a problem with the spec and not our 
implementation.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
