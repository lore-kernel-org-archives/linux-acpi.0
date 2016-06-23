From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: pci_slot: Use generic pr_debug utility
Date: Thu, 23 Jun 2016 02:33:15 +0200
Message-ID: <7381765.P08tLi9Ng0@vostro.rjw.lan>
References: <79c094d611a0e844263e01be80dbea3dbbbcfa20.1464365586.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <79c094d611a0e844263e01be80dbea3dbbbcfa20.1464365586.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday, May 27, 2016 09:13:29 AM Joe Perches wrote:
> Remove the dbg macro and debug module parameter and use
> the generic kernel facility.
> 
> Trivially reduces defconfig object size on x86-64
> 
> $ size drivers/acpi/pci_slot.o*
>    text	   data	    bss	    dec	    hex	filename
>     880	    752	      4	   1636	    664	drivers/acpi/pci_slot.o.new
>     935	    752	      5	   1692	    69c	drivers/acpi/pci_slot.o.old
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied, thanks!
