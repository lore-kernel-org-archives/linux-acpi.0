From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/5] ACPI: Tie ACPI backlight devices to PCI
	devices if	possible
Date: Sun, 6 Feb 2011 20:56:19 +0000
Message-ID: <20110206205619.GA21472@srcf.ucam.org>
References: <1295033065-13450-1-git-send-email-mjg@redhat.com>
	<1295033065-13450-5-git-send-email-mjg@redhat.com>
	<201102062135.08171.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <201102062135.08171.rjw@sisk.pl>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, akpm@linux-foundation.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Feb 06, 2011 at 09:35:07PM +0100, Rafael J. Wysocki wrote:
> > +		acpi_get_parent(device->dev->handle, &acpi_parent);
> > +
> > +		pdev = acpi_get_pci_dev(acpi_parent);
> > +		if (pdev) {
> > +			parent = &pdev->dev;
> > +			pci_dev_put(pdev);
> > +		}
> 
> I'm afraid you can't do that or suspend problems will happen.

Ugh. Ok, how can we fix this?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
