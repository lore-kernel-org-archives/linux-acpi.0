From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Documentation/acpi: add the missing '='
Date: Thu, 29 Jan 2015 02:57:57 +0100
Message-ID: <3096114.ORU24SZqu9@vostro.rjw.lan>
References: <1421330356-4051-1-git-send-email-bywxiaobai@163.com> <2132979.yiiZbQ1huf@vostro.rjw.lan> <20150128150408.7c76ce05@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150128150408.7c76ce05@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Yaowei Bai <bywxiaobai@163.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, January 28, 2015 03:04:08 PM Jonathan Corbet wrote:
> On Wed, 28 Jan 2015 21:12:36 +0100
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
> > > On Thu, 15 Jan 2015 21:59:16 +0800
> > > Yaowei Bai <bywxiaobai@163.com> wrote:
> > >   
> > > > -			.acpi_match_table  ACPI_PTR(mpu3050_acpi_match),
> > > > +			.acpi_match_table = ACPI_PTR(mpu3050_acpi_match),  
> > > 
> > > Applied to the docs tree, thanks.  
> > 
> > I've applied this one too.  Should I drop it?
> 
> I'll drop it, no worries.

OK, thanks!
