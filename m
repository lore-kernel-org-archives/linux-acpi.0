From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 0/2] acpi: apei: Bug fix to enable APEI support for
 ARMv8
Date: Sun, 10 Jan 2016 12:08:14 +0100
Message-ID: <20160110110813.GB22896@pd.tnic>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <CAPw-ZT=Kor1E7NpAkoAyJtULiCGuCCsoSES05Dr6-eUUS8dDHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:43045 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756542AbcAJLIY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Jan 2016 06:08:24 -0500
Content-Disposition: inline
In-Reply-To: <CAPw-ZT=Kor1E7NpAkoAyJtULiCGuCCsoSES05Dr6-eUUS8dDHg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Loc Ho <lho@apm.com>
Cc: Doug Thompson <dougthompson@xmission.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Fu Wei <fu.wei@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-edac <linux-edac@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-acpi@vger.kernel.org, Jon Masters <jcm@redhat.com>, "patches@apm.com" <patches@apm.com>

On Fri, Jan 08, 2016 at 04:30:48PM -0800, Loc Ho wrote:
> It has been awhile and I thought I check again on this. Any issue with
> these two changes as it is needed for ARMv8 64-bit APEI support.
> Without these two changes, APEI support will NOT work with X-Gene
> platforms.

Patch 1 could be improved. It is Rafael's call in the end of the day.

Patch 2 looks ok to me.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
