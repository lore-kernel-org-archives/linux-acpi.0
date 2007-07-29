From: "Frank Hale" <frankhale@gmail.com>
Subject: Re: ACPI on Averatec 2370
Date: Sun, 29 Jul 2007 19:58:39 +0000
Message-ID: <5ebbd9b50707291258l1d67fa20g3542dd3bbfcb4aef@mail.gmail.com>
References: <5ebbd9b50707291105w316f98e5h3fa17204c9119a2f@mail.gmail.com>
	 <46ACD8DB.2020108@googlemail.com>
	 <Pine.LNX.4.64.0707291428100.7379@lancer.cnet.absolutedigital.net>
	 <5ebbd9b50707291158n4cfffcbl7f620bd10181fb6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:4983 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763611AbXG2T6k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Jul 2007 15:58:40 -0400
Received: by an-out-0708.google.com with SMTP id d31so245476and
        for <linux-acpi@vger.kernel.org>; Sun, 29 Jul 2007 12:58:39 -0700 (PDT)
In-Reply-To: <5ebbd9b50707291158n4cfffcbl7f620bd10181fb6d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cal Peake <cp@absolutedigital.net>
Cc: Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com

Your work around seems to do the trick. I took out SMP support, added
ACPI and now it boots normally.

On 7/29/07, Frank Hale <frankhale@gmail.com> wrote:
> > Frank, can you try a non-SMP build with ACPI and see if you still have the
> > problem?
>
> I certainly will, I never tried it without it so now I am curious.
> Thanks a bunch!
>
