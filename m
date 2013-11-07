From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [patch 2/2] ACPI, extlog: remove unneeded NULL check
Date: Thu, 07 Nov 2013 01:09:38 +0100
Message-ID: <1904928.e3mTdgXtnf@vostro.rjw.lan>
References: <20131105202007.GB3949@elgon.mountain> <4572462.cKQzNDzG5Z@vostro.rjw.lan> <CA+8MBb+5-o=XoWb61q7FkbhGK-LWTbRyxgSVK+Rb0a1U20nAcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <CA+8MBb+5-o=XoWb61q7FkbhGK-LWTbRyxgSVK+Rb0a1U20nAcw@mail.gmail.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Len Brown <lenb@kernel.org>, Gong <gong.chen@linux.intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, November 06, 2013 02:45:18 PM Tony Luck wrote:
> On Wed, Nov 6, 2013 at 2:06 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > I'm wondering what kernel you have checked, because drivers/acpi/acpi_extlog.c
> > is not present in the mainline or even in linux-next?
> 
> It's in the "tip" tree ... and seems to be in next-20131106

Well, OK.  Who's going to maintain this file?

Rafael

