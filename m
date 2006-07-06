From: Paul Drynoff <pauldrynoff@gmail.com>
Subject: Re: linux-2.6.17-mm6: can not boot: bad spinlock magic
Date: Thu, 6 Jul 2006 14:27:12 +0400
Message-ID: <20060706142712.a26f56eb.pauldrynoff@gmail.com>
References: <20060706130849.f227ae98.pauldrynoff@gmail.com>
	<20060706023131.04de8092.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:3355 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965186AbWGFKUx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Jul 2006 06:20:53 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2609525ugf
        for <linux-acpi@vger.kernel.org>; Thu, 06 Jul 2006 03:20:51 -0700 (PDT)
In-Reply-To: <20060706023131.04de8092.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, rhdt@bartol.udel.edu

Thanks for patch, it fixes bug for me.

On Thu, 6 Jul 2006 02:31:31 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Cc: "Brown, Len" <len.brown@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
