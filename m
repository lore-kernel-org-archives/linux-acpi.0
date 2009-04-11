From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH 1/2] toshiba-acpi: Add support for hotkey notifications
Date: Sat, 11 Apr 2009 21:50:35 +0200
Message-ID: <200904112150.38010.elendil@planet.nl>
References: <20090331214501.GC29489@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757664AbZDKTuw@vger.kernel.org>
In-reply-To: <20090331214501.GC29489@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, dsilvers@simtec.co.uk, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org, lenb@intel.com
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> Calling the ENAB method on Toshiba laptops results in notifications
> being sent when laptop hotkeys are pressed. This patch simply calls that
> method and sets up an input device if it's successful.

Hi Matthew,

On my Satellite A40-241 the patch works fine for the Fn keys, but it does 
not work for the multimedia keys next to the power button. No event is 
generated (I tested this by directly reading the /dev/input/eventX file).

Any chance those could be made to work too?

Cheers,
FJP
