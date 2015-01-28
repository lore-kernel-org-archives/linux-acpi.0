From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation/acpi: add the missing '='
Date: Wed, 28 Jan 2015 15:04:08 -0700
Message-ID: <20150128150408.7c76ce05@lwn.net>
References: <1421330356-4051-1-git-send-email-bywxiaobai@163.com>
	<20150128120850.5f6504a7@lwn.net>
	<2132979.yiiZbQ1huf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <2132979.yiiZbQ1huf@vostro.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Yaowei Bai <bywxiaobai@163.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 28 Jan 2015 21:12:36 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> > On Thu, 15 Jan 2015 21:59:16 +0800
> > Yaowei Bai <bywxiaobai@163.com> wrote:
> >   
> > > -			.acpi_match_table  ACPI_PTR(mpu3050_acpi_match),
> > > +			.acpi_match_table = ACPI_PTR(mpu3050_acpi_match),  
> > 
> > Applied to the docs tree, thanks.  
> 
> I've applied this one too.  Should I drop it?

I'll drop it, no worries.

jon
