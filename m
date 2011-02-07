From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/5] ACPI: Tie ACPI backlight devices to PCI devices if
	possible
Date: Mon, 7 Feb 2011 21:34:26 +0000
Message-ID: <20110207213426.GA23843@srcf.ucam.org>
References: <1295033065-13450-1-git-send-email-mjg@redhat.com>
	<20110206230558.GA23889@srcf.ucam.org>
	<201102070034.43691.rjw@sisk.pl>
	<201102071432.35656.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <201102071432.35656.bjorn.helgaas@hp.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, akpm@linux-foundation.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 07, 2011 at 02:32:35PM -0700, Bjorn Helgaas wrote:

> I'm not familiar with video devices, but I agree, this situation does
> feel broken.  Is it the case that there's a PCI device as well as an
> ACPI namespace Device for the same piece of hardware?  If so, I assume
> the reason for the ACPI Device is to have a "standard" interface to
> a platform knob like backlight control.
> 
> In that case, it seems like we should rely on PCI for enumeration and
> driver binding, have some sort of hook the PCI driver could use to
> twiddle that knob (using the ACPI methods), and make the ACPI Device
> ineligible for driver binding.  In other words, it sounds like part
> of the problem is that we have two drivers binding to what's really
> a single piece of hardware.

Part of the problem is that ACPI video devices aren't inherently PCI 
devices.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
