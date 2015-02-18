From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] ACPI / LPSS: Always disable I2C host controllers
Date: Wed, 18 Feb 2015 14:54:08 +0200
Message-ID: <20150218125408.GR1508@lahna.fi.intel.com>
References: <1424260217-7719-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424260217-7719-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Yang A Fang <yang.a.fang@intel.com>, Yu Chen <yu.c.chen@intel.com>, Graham Whaley <graham.whaley@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 18, 2015 at 01:50:16PM +0200, Mika Westerberg wrote:
> On Baytrail and Braswell the BIOS might leave the I2C host controllers
> enabled, probably because it uses them for its on purposes. This is fine in
                                                 ^^^^^^^^^^^
As pointed out by Graham Whaley, it should say "own purposes".

Rafael, do you want me to resend this patch?
