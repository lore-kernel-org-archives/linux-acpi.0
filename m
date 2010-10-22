From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/9] ACPI, APEI patches for 2.6.37
Date: Fri, 22 Oct 2010 01:50:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010220147560.27300@localhost.localdomain>
References: <1287538620-7442-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1287538620-7442-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 20 Oct 2010, Huang Ying wrote:

> [PATCH 2/9] Add lock-less version of bitmap_set/clear
> [PATCH 3/9] lock-less NULL terminated single list implementation
> [PATCH 4/9] lock-less general memory allocator

What kinds of tests has this lockless lib code been subject to?
This is generic code, does it play on multiple architectures?

thanks,
Len Brown Intel Open Source Technology Center
