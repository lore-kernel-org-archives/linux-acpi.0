From: fanderay <fanderay4@googlemail.com>
Subject: Re: [Regression] sony-laptop breaks resume from S2RAM (was: Re:
	[linux-pm] Resume after suspend-to-ram broken for Vaio SR19VN in 30rc2)
Date: Wed, 22 Apr 2009 21:35:13 +0100
Message-ID: <31c940650904221335v21fbffc2y2e9598b564d65659@mail.gmail.com>
References: <31c940650904201152y5f440237rb9c49f1aedfef5a6@mail.gmail.com>
	 <200904212050.25531.rjw@sisk.pl>
	 <31c940650904220555v1c1a6046ifa40b9c81b390731@mail.gmail.com>
	 <200904222202.24271.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:34592 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977AbZDVUfN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Apr 2009 16:35:13 -0400
Received: by rv-out-0506.google.com with SMTP id f9so142893rvb.1
        for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2009 13:35:13 -0700 (PDT)
In-Reply-To: <200904222202.24271.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>

On Wed, Apr 22, 2009 at 9:02 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> Hi Rafael,
>>
>> I found the problem: it's the Sony laptop driver. =A0With
>> CONFIG_SONY_LAPTOP=3Dy, the hard freeze on resume occurs. =A0Without=
 this
>> driver in the kernel, resume after s2ram -f -p appears to work
>> correctly.
>
> It seems to be an ACPI problem, then. =A0Added some CCs.

Thanks, I raised bug <http://bugzilla.kernel.org/show_bug.cgi?id=3D1314=
8>.

> Thanks,
> Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
