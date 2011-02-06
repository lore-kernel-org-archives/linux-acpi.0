From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/5] ACPI: Tie ACPI backlight devices to PCI devices if
	possible
Date: Sun, 6 Feb 2011 23:05:58 +0000
Message-ID: <20110206230558.GA23889@srcf.ucam.org>
References: <1295033065-13450-1-git-send-email-mjg@redhat.com>
	<201102062341.19631.rjw@sisk.pl>
	<20110206225308.GA23557@srcf.ucam.org>
	<201102070001.25814.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <201102070001.25814.rjw@sisk.pl>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, akpm@linux-foundation.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 07, 2011 at 12:01:25AM +0100, Rafael J. Wysocki wrote:

> Yes, it seems so, but I'm not sure what the short term consequences of that
> change will be.  Perhaps there will be none. :-)

Ok, I'll have a play with that. Maybe we should be fixing this up 
somehow in the acpi-pci glue code? It seems wrong to have acpi devices 
resumed before the PCI device they're associated with.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
