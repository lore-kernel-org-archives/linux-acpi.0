From: "Scott Thompson" <postfail@hushmail.com>
Subject: Re: [RFC] CONFIG_PM_LEGACY = compiler warnings for deprecation ... solution?
Date: Wed, 01 Aug 2007 09:53:31 -0400
Message-ID: <20070801135332.7977F22825@mailserver9.hushmail.com>
Reply-To: postfail@hushmail.com
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp3.hushmail.com ([65.39.178.135]:50772 "EHLO
	smtp3.hushmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbXHANxi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Aug 2007 09:53:38 -0400
Received: from smtp3.hushmail.com (localhost.hush.com [127.0.0.1])
	by smtp3.hushmail.com (Postfix) with SMTP id 47E0B61C34
	for <linux-acpi@vger.kernel.org>; Wed,  1 Aug 2007 13:53:13 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org, pavel@suse.cz, linux-pm@lists.linux-foundation.org



On Wed, 01 Aug 2007 06:57:25 -0400 "Rafael J. Wysocki" 
<rjw@sisk.pl> wrote:
>We are going to remove the legacy PM altogether, AFAICS, although 
>there still
>are some obstacles.
>

Thanks -- I had checked Documentation/feature_removal_schedule.txt 
for this, but looks like the obsoletion is referenced in 
Documentation/pm.txt.

I'll offer to patch in the solution I proposed to prevent the 
compile warnings in the interim if you're interested...

---------------------------------------
Scott Thompson / postfail@hushmail.com
---------------------------------------

--
Click to get 150,000 in student loans and find the lowest rates
http://tagline.hushmail.com/fc/Ioyw6h4d7Femgqznt3WSEFC1KSqiZZ3eudvCzwr9tOXpy1LdMQYzRK/

