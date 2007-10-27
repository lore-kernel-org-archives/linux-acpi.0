From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] 2.6.24-rc1: ensure "present" sysfs attribute even if
	battery is absent
Date: Sat, 27 Oct 2007 15:32:04 -0400
Message-ID: <1193513524.2915.18.camel@shinybook.infradead.org>
References: <200710272054.31160.arvidjaar@mail.ru>
	 <20071027184249.GA2982@zarina>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:58494 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbXJ0Tby (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Oct 2007 15:31:54 -0400
In-Reply-To: <20071027184249.GA2982@zarina>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: cbou@mail.ru
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, davidz@redhat.com, rhughes@redhat.com

On Sat, 2007-10-27 at 22:42 +0400, Anton Vorontsov wrote:
> Well, PROP_PRESENT wasn't my idea, currently it's used by pmu and
> olpc drivers becuase it's not trivial to register/unregister their
> batteries on physical insertion/removal. I have some plans to teach
> at least pmu batteries to not use PROP_PRESENT. I don't have any
> OLPC, thus I can't convert it.

Actually it's not hard to do that. It was done this way in response to a
request from the userspace side. IIRC.

-- 
dwmw2

