From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Add intel drm blacklist to intel_opregion_present
	detect
Date: Mon, 23 Aug 2010 18:51:18 +0100
Message-ID: <20100823175118.GA28319@srcf.ucam.org>
References: <1282563648-21935-1-git-send-email-jlee@novell.com> <20100823114938.GA19879@srcf.ucam.org> <201008231953.22459.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201008231953.22459.trenn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, linux-kernel@vger.kernel.org, gregkh@suse.de, jlee@novell.com, Dennis.Jansen@web.de, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 23, 2010 at 07:53:21PM +0200, Thomas Renninger wrote:

> Hm, needing a module option to get a system running is not what the user expects.
> By default, the system should run fine and a module option should be added
> as a workaround or for debugging only.

How about we do this instead: add a psb stub driver that does nothing 
other than call acpi_backlight_register()?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
