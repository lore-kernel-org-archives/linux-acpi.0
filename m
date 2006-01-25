From: "John H." <mistamaila@gmail.com>
Subject: Re: acpidmp and acpixtract
Date: Wed, 25 Jan 2006 12:56:44 -0600
Message-ID: <5b9417770601251056j30f3a262n62c72e2cfb3db8e3@mail.gmail.com>
References: <5b9417770601251017i283c5279mcc14250cd4e816c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:52534 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932094AbWAYS4r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jan 2006 13:56:47 -0500
Received: by zproxy.gmail.com with SMTP id 14so175084nzn
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jan 2006 10:56:44 -0800 (PST)
In-Reply-To: <5b9417770601251017i283c5279mcc14250cd4e816c9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

hmm,
#!/usr/bin/perl
#
# acpixtract - extract raw table from acpidmp output
#
# Example: cat mail.txt | ./acpixtract DSDT | ./acpidisasm


how do i get the acpidmp output of my bios in order to use to diagnose?



On 1/25/06, John H. <mistamaila@gmail.com> wrote:
> i am trying to use acpidmp which i've compiled from cvs from sourceforge
> when i run perl /usr/local/bin/acpixtract
> to extract bios, it never "stops" and dumps a file.
> what am i doing wrong?
>
