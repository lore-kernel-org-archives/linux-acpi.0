From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/12] ACPI: constify patches and other minor fixes
Date: Tue, 16 Jun 2015 00:49:45 +0200
Message-ID: <1575178.P3pyudAmuh@vostro.rjw.lan>
References: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61016 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750918AbbFOWXs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2015 18:23:48 -0400
In-Reply-To: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathias Krause <minipli@googlemail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Saturday, June 13, 2015 02:26:48 PM Mathias Krause wrote:
> Hi Rafael, Len,
> 
> this series constifies a few variables in the ACPI code that are read
> only and therefore can be const. The main goal is to constify all users
> of struct acpi_device_id, but while digging through the code I found a
> few other places that could be improved too (constifying other variables
> in patches 1, 2, 4 and 9 as adding __init annotations where sensible in
> patch 7 or dropping bogus annotations in patch 3).
> 
> This series only handles the ACPI related bits for the constification of
> struct acpi_device_id but all other users have been changed too (you've
> been Cc'ed on the corresponding patches).
> 
> Please apply!

I've queued up the series for 4.2 except for patches [3/12] and [4/12].

My recollection of the __refdata in the processor driver is that it was needed
for some obscure reason, so that one requires some more thorough code inspection
and the [4/12] gets in the way of something (I'll apply it later when I'm done
with that other thing).


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
