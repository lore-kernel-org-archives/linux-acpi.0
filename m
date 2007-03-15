From: "Richard Hughes" <hughsient@gmail.com>
Subject: Re: [PATCH 01/22] cpuidle take2: Core cpuidle infrastructure
Date: Thu, 15 Mar 2007 13:13:11 +0000
Message-ID: <15e53e180703150613k7cda1497pec39160343222ad5@mail.gmail.com>
References: <11734992592550-git-send-email-lenb@kernel.org>
	 <11734992601441-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:4190 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933539AbXCONNM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Mar 2007 09:13:12 -0400
Received: by an-out-0708.google.com with SMTP id b33so145639ana
        for <linux-acpi@vger.kernel.org>; Thu, 15 Mar 2007 06:13:11 -0700 (PDT)
In-Reply-To: <11734992601441-git-send-email-lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Adam Belay <abelay@novell.com>, Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

On 10/03/07, Len Brown <lenb@kernel.org> wrote:
>  arch/i386/Kconfig                  |    2 +
>  arch/x86_64/Kconfig                |    2 +
>  drivers/Makefile                   |    1 +
>  drivers/cpuidle/Kconfig            |   28 +++
>  drivers/cpuidle/Makefile           |    5 +
>  drivers/cpuidle/cpuidle.c          |  287 ++++++++++++++++++++++++++++++
>  drivers/cpuidle/cpuidle.h          |   52 ++++++
>  drivers/cpuidle/driver.c           |  219 +++++++++++++++++++++++
>  drivers/cpuidle/governor.c         |  160 +++++++++++++++++
>  drivers/cpuidle/governors/Makefile |    5 +
>  drivers/cpuidle/governors/ladder.c |  229 ++++++++++++++++++++++++
>  drivers/cpuidle/sysfs.c            |  340 ++++++++++++++++++++++++++++++++++++
>  include/linux/cpuidle.h            |  160 +++++++++++++++++

What about some documentation so that userspace knows what to do with
this new framework?

Richard.
