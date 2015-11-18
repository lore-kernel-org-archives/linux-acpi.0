From: Matthew Garrett <mjg59@coreos.com>
Subject: Re: [PATCH] pci: completely disable aspm if it's unsupported
Date: Wed, 18 Nov 2015 11:19:02 -0800
Message-ID: <CAPeXnHsdA0rDdSh020Yc7GUTQ_hQiEKdSOa1vcu1Ov=mJn4eDA@mail.gmail.com>
References: <1447856703-2566-1-git-send-email-jbacik@fb.com>
	<20151118184038.GA4462@localhost>
	<564CCAC2.5050600@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <564CCAC2.5050600@fb.com>
Sender: linux-pci-owner@vger.kernel.org
To: Josef Bacik <jbacik@fb.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, shli@fb.com, kernel-team@fb.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 18, 2015 at 11:00 AM, Josef Bacik <jbacik@fb.com> wrote:
> It looks to me I'm doing what Matthew set out to do, only with a bigger
> hammer ;).  His patch still allowed the initialization of the ASPM stuff,
> like setting up the clocks and such, but then made it so we couldn't change
> the ASPM state at all.  My patch goes the step further of not even doing the
> initialization stuff.  Thanks,

That sounds fine - if we don't gain _OSC control then we should avoid
touching any of the ASPM register state that the firmware has set. I'm
happy to call the current state broken.
