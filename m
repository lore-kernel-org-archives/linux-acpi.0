From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V2] ACPI/Battery: Add a _BIX quirk for NEC LZ750/LS
Date: Tue, 14 Jan 2014 16:06:01 +0000
Message-ID: <20140114160601.GB4307@srcf.ucam.org>
References: <1389019837-13619-1-git-send-email-tianyu.lan@intel.com>
 <20140106175912.GA2754@core.coreip.homeip.net>
 <1793775.ULjNzyMivD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1793775.ULjNzyMivD@vostro.rjw.lan>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, fcr@adinet.com.uy, l@dorileo.org, "3.8+" <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 06, 2014 at 11:25:53PM +0100, Rafael J. Wysocki wrote:

> Queued up as a fix for 3.13 (I fixed up the indentation).

Ah, sorry, I missed this chunk of the thread. If the system provides 
valid _BIF data then we should possibly just fall back to that rather 
than adding another quirk table.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
