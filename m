From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Documentation/acpi: add the missing '='
Date: Wed, 28 Jan 2015 21:12:36 +0100
Message-ID: <2132979.yiiZbQ1huf@vostro.rjw.lan>
References: <1421330356-4051-1-git-send-email-bywxiaobai@163.com> <20150128120850.5f6504a7@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150128120850.5f6504a7@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Yaowei Bai <bywxiaobai@163.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, January 28, 2015 12:08:50 PM Jonathan Corbet wrote:
> On Thu, 15 Jan 2015 21:59:16 +0800
> Yaowei Bai <bywxiaobai@163.com> wrote:
> 
> > -			.acpi_match_table  ACPI_PTR(mpu3050_acpi_match),
> > +			.acpi_match_table = ACPI_PTR(mpu3050_acpi_match),
> 
> Applied to the docs tree, thanks.

I've applied this one too.  Should I drop it?

Rafael
