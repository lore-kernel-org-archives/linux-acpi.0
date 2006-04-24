From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Mon, 24 Apr 2006 10:54:23 +0400
Message-ID: <444C761F.6010603@linux.intel.com>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <mj+md-20060420.165714.18107.albireo@ucw.cz> <4447C020.3010003@linux.intel.com> <20060420220731.GF2352@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:25556 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750781AbWDXGyd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Apr 2006 02:54:33 -0400
In-Reply-To: <20060420220731.GF2352@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Martin Mares <mj@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Pavel Machek wrote:
>>> I don't see any reason for treating some keys or buttons 
>>> differently.
>>> A key is just a key.
> 
>> There is one special key anyway -- reset...
> 
> Your point is? There's also hardware power button on many machines.
> They are not controllable by software => they are not relevant to this
> discussion.
> 								Pavel
> 
Really? And you are what are you going to do with bugs about "my power button doesn't remap, and always shuts down my machine?"
