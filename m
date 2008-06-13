From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: linux-next Regression: Unable to locate IOAPIC
Date: Fri, 13 Jun 2008 16:42:23 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0806131638320.29380@cliff.in.clinika.pl>
References: <200806051100.12885.dex@dragonslave.de> <200806102229.10512.dex@dragonslave.de>
 <4851AA24.7060906@gmail.com> <200806131307.39807.dex@dragonslave.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <200806131307.39807.dex@dragonslave.de>
Sender: linux-next-owner@vger.kernel.org
To: webmaster@dragonslave.de
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 13 Jun 2008, Daniel Exner wrote:

> I attached dmesg and config , both from working 2.6.26-rc5 with git-acpi patch 
> below and from linux-next snapshot 20080604.

 Unfortunately dmesg.rc5.acpi is missing important information at the
beginning -- please retry with a larger buffer (LOG_BUF_SHIFT).

  Maciej
