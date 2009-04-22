From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Regression] sony-laptop breaks resume from S2RAM (was: Re: [linux-pm] Resume after suspend-to-ram broken for Vaio SR19VN in 30rc2)
Date: Wed, 22 Apr 2009 22:02:23 +0200
Message-ID: <200904222202.24271.rjw@sisk.pl>
References: <31c940650904201152y5f440237rb9c49f1aedfef5a6@mail.gmail.com> <200904212050.25531.rjw@sisk.pl> <31c940650904220555v1c1a6046ifa40b9c81b390731@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36140 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbZDVUCa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Apr 2009 16:02:30 -0400
In-Reply-To: <31c940650904220555v1c1a6046ifa40b9c81b390731@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fanderay <fanderay4@googlemail.com>
Cc: linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>

On Wednesday 22 April 2009, fanderay wrote:
> Hi Rafael,
> 
> I found the problem: it's the Sony laptop driver.  With
> CONFIG_SONY_LAPTOP=y, the hard freeze on resume occurs.  Without this
> driver in the kernel, resume after s2ram -f -p appears to work
> correctly.

It seems to be an ACPI problem, then.  Added some CCs.

Thanks,
Rafael
