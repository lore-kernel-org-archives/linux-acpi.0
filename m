From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 2/4] eeepc-laptop: Fix cpufv
Date: Sat, 13 Jun 2009 08:45:39 +0200
Message-ID: <71cd59b00906122345y3546a8e7y57aaa86ac13c4600@mail.gmail.com>
References: <1244449010-7995-1-git-send-email-corentincj@iksaif.net>
	 <1244449010-7995-2-git-send-email-corentincj@iksaif.net>
	 <1244449010-7995-3-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:64005 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857AbZFMGpi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2009 02:45:38 -0400
Received: by bwz9 with SMTP id 9so2447660bwz.37
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2009 23:45:39 -0700 (PDT)
In-Reply-To: <1244449010-7995-3-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Hi Len,
2.6.30 is out, please don't merge this patch, it'll break userspace API.
Other patch are still ok.
Thanks,


-- 
Corentin Chary
http://xf.iksaif.net - http://uffs.org
