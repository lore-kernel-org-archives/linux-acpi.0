From: Johannes Weiner <hannes@saeurebad.de>
Subject: Re: thinkpad_acpi: define _sta only when needed
Date: Wed, 16 Jan 2008 22:10:27 +0100
Message-ID: <87sl0xcw8s.fsf@saeurebad.de>
References: <1200488504-6789-1-git-send-email-hannes@saeurebad.de>
	<20080116191317.GA29449@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:35150 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbYAPVJ1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2008 16:09:27 -0500
In-Reply-To: <20080116191317.GA29449@khazad-dum.debian.net> (Henrique de
	Moraes Holschuh's message of "Wed, 16 Jan 2008 17:13:17 -0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Henrique,

Henrique de Moraes Holschuh <hmh@hmh.eng.br> writes:

> On Wed, 16 Jan 2008, Johannes Weiner wrote:
>> Define _sta() helper conditionally; also remove its prototype from
>> the internal header and also some other unneeded ones.
>> 
>> This function is only needed when the bay or the dock subdriver is
>> enabled.  Otherwise, gcc complains about an unused static function.
>
> Johannes, thanks for the patches, but NAK.  A similar group of patches that
> clean up the _sta and heander file (kills it, actually) has already been
> sent to Len Brown to be merged for 2.6.25.

Sorry, I missed to check his tree in advance.  And if the work is
already done - even better! :)

	Hannes
