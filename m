From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/4] X86: Revamp reboot behaviour to match Windows more
	closely
Date: Fri, 11 Mar 2011 22:15:17 +0000
Message-ID: <20110311221517.GA24173@srcf.ucam.org>
References: <1299877940-6870-1-git-send-email-mjg@redhat.com> <201103112308.18221.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201103112308.18221.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 11, 2011 at 11:08:18PM +0100, Rafael J. Wysocki wrote:
> On Friday, March 11, 2011, Matthew Garrett wrote:
> > Windows reboots by hitting the ACPI reboot vector (if available), trying
> > the keyboard controller, hitting the ACPI reboot vector again and then
> > giving the keyboard controller one last go. Rework our reboot process a
> > little to default to matching this behaviour, although we'll fall through
> > to attempting a triple fault if nothing else works.
> 
> Does this fix a particular problem observed in practice?

Yup. We're seeing an increasing number of machines that don't implement 
the legacy keyboard controller at all and fail to reboot if you poke it. 
The expectation appears to be that you use the ACPI reboot vector on 
these machines.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
