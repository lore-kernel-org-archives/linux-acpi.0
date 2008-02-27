From: Jarek Poplawski <jarkao2@gmail.com>
Subject: Re: [Bugme-new] [Bug 10071] New: kernel hang in inet_init
Date: Wed, 27 Feb 2008 13:49:48 +0000
Message-ID: <20080227134948.GA6422@ff.dom.local>
References: <20080225140034.5ef88935.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:47522 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755653AbYB0Nsr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Feb 2008 08:48:47 -0500
Received: by ug-out-1314.google.com with SMTP id z38so341307ugc.16
        for <linux-acpi@vger.kernel.org>; Wed, 27 Feb 2008 05:48:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080225140034.5ef88935.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yannick.dirou@axetic.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, netdev@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On 25-02-2008 23:00, Andrew Morton wrote:
> On Sat, 23 Feb 2008 00:34:06 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:
> 
>> http://bugzilla.kernel.org/show_bug.cgi?id=10071
...
>>      KernelVersion: 2.6.25 rc2 latest git
...
>> there seem to be a weird interaction between acpi and inet_init
>>
>> any hint on how to provide better information

Yannick, here are a few questions:

- is this bug just with this git, but OK before (or 2.6.25-rc3?)?
- do all other drivers work properly and only net is a problem?
- could you add to bugzilla full dmesg in both cases?

Regards,
Jarek P.
