From: Shawn Starr <shawn.starr@rogers.com>
Subject: [BUG][2.6.10-rc2-mm2] ACPI S3 suspend to RAM broken (may be USB unable to resume)
Date: Sun, 21 Nov 2004 18:11:07 -0500
Message-ID: <200411211811.07785.shawn.starr@rogers.com>
References: <200411161838.28344.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261830AbUKUXLM@vger.kernel.org>
In-Reply-To: <200411161838.28344.shawn.starr@rogers.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org


-mm2 suffers this problem as well. I still am looking at what is causing it.

On November 16, 2004 18:38, Shawn Starr wrote:
> As of 2.6.10-rc1 + I can no longer resume from S3 (suspend-to-RAM),  When
> it begins to resume, it seems to get stuck with USB (going to confirm)..
> The laptop stays in a stuck state (cresent-moon remains lit).
>
> I have IBM-ACPI extras turned on (compiled in).
>
> Anyone else report this?
>
> Shawn.
