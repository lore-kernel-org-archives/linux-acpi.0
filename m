From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Thu, 20 Apr 2006 21:08:48 +0400
Message-ID: <4447C020.3010003@linux.intel.com>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <mj+md-20060420.165714.18107.albireo@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751170AbWDTRJT@vger.kernel.org>
In-Reply-To: <mj+md-20060420.165714.18107.albireo@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Mares <mj@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Martin Mares wrote:
> Hello!
> 
>> Generic application does not need to know if power, sleep, or lid button is 
>> pressed, so you will need to intercept them from input stream... I cannot 
>> find any reason to mix these buttons into input, do you?
> 
> Neither does a generic application need to know if the NumLock key is just
> pressed. This doesn't mean anything.
> 
> I don't see any reason for treating some keys or buttons differently.
> A key is just a key.
> 
> 				Have a nice fortnight
There is one special key anyway -- reset...
