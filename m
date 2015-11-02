From: Ilia Mirkin <imirkin@alum.mit.edu>
Subject: ASL help
Date: Mon, 2 Nov 2015 14:39:32 -0500
Message-ID: <CAKb7Uvgg=Y+5DzQK9Z7Bo3Rs22DDCm_o7C5OwB8ucYr=pCCoUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37063 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbbKBTjd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Nov 2015 14:39:33 -0500
Received: by wicfv8 with SMTP id fv8so57348859wic.0
        for <linux-acpi@vger.kernel.org>; Mon, 02 Nov 2015 11:39:32 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hello,

Not sure where I can ask questions about ASL, but figured this might
reach people who know this stuff off-hand. Can someone explain what
this statement (as decoded by iasl -d) does:

Local0 += Arg0 = (VRMB (0x04) + Local0)

This is the first line of a _ROM function (see
https://bugs.freedesktop.org/show_bug.cgi?id=90626#c26 for the full
decode). While I can obviously make guesses (and logically it would be
Local0 = VRMB(0x04) + Arg0 based on subsequent use), but I'd like to
know for sure (esp as we appear to be having issues with this
particular method's implementation).

Thanks for any info you can provide.

  -ilia
