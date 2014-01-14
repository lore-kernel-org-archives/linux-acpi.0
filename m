From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] ACPI/Battery: Add a _BIX quirk for NEC LZ750/LS
Date: Tue, 14 Jan 2014 22:37:02 +0100
Message-ID: <5255063.SeYbBZqxVQ@vostro.rjw.lan>
References: <1389019837-13619-1-git-send-email-tianyu.lan@intel.com> <1793775.ULjNzyMivD@vostro.rjw.lan> <20140114160601.GB4307@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140114160601.GB4307@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Lan Tianyu <tianyu.lan@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, fcr@adinet.com.uy, l@dorileo.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, January 14, 2014 04:06:01 PM Matthew Garrett wrote:
> On Mon, Jan 06, 2014 at 11:25:53PM +0100, Rafael J. Wysocki wrote:
> 
> > Queued up as a fix for 3.13 (I fixed up the indentation).
> 
> Ah, sorry, I missed this chunk of the thread. If the system provides 
> valid _BIF data then we should possibly just fall back to that rather 
> than adding another quirk table.

The problem is to know that _BIX is broken.  If we could figure that out
upfront, we woulnd't need the quirk table in any case.

Tianyu, can we do some effort during the driver initialization to detect
this breakage and handle it without blacklisting systems?

Rafael
