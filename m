From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch] acpi: introduce "acpi_addr=" parameter for kdump
Date: Mon, 21 Mar 2011 11:56:29 -0400
Message-ID: <20110321155629.GF2694@redhat.com>
References: <1299766243-494-1-git-send-email-amwang@redhat.com>
 <20110310143923.GB29464@redhat.com>
 <m1oc5ig90b.fsf@fess.ebiederm.org>
 <20110310185019.GB23105@srcf.ucam.org>
 <4D86F2C2.9080707@redhat.com>
 <m1hbawkifj.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <m1hbawkifj.fsf@fess.ebiederm.org>
Sender: linux-doc-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Cong Wang <amwang@redhat.com>, Matthew Garrett <mjg@redhat.com>, linux-kernel@vger.kernel.org, Takao Indoh <tindoh@redhat.com>, Randy Dunlap <rdunlap@xenotime.net>, Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 21, 2011 at 01:05:04AM -0700, Eric W. Biederman wrote:
> Cong Wang <amwang@redhat.com> writes:
> 
> > Eric, any comments?
> 
> You have my Nack.
> 
> We are doing stupid and unnecessary things, that cause us problems with
> EFI.  If we stop doing those stupid and unnecessary things we won't have
> problems.
> 
> So I don't see the point of adding more stupid and unnecessary work, so
> we can continue to do stupid and unnecessary things and cause ourselves
> problems.

Hi Eric,

I went through your proposal in last mail and frankly speaking I understand
very little of it (due to my lack of knowledge in this area). Had couple
of very high level thoughts though.

- Matthew raised the issue of ACPI not being complete replacement as
  reboot path uses EFI.

- I am assuming with this notion of run time services in EFI, one can
  expect more and more issues down the line where people will want to
  call into EFI. So trying to enforce this notion that never call EFI
  from kernel once kernel is booted and isolate the EFI runtime services
  to make kexec/kdump work might not be best solution.

Matthew and I were chatting in general about it couple of days back and
mattew suggested how about if we embrace the idea of booting the kernel
always in physical mode (both first and second) and keep that extra set
of pagetables around to make EFI calls. That way kexec/kdump should just
work and kernel changes also might not be too much.

The potential problem with this is that this might expose various kind
of BIOS issues with different vendors as vendors might not test the
physical path.

May be we can give it a try and see if it flies?

Thanks
Vivek 
