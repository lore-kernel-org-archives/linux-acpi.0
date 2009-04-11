From: Niel Lambrechts <niel.lambrechts@gmail.com>
Subject: Re: 2.6.30-rc1 (latest git): thinkpad-acpi: cannot control brightness
 with hotkeys
Date: Sun, 12 Apr 2009 01:10:48 +0200
Message-ID: <49E12378.8070200@gmail.com>
References: <49E10684.5090101@gmail.com> <20090411150555.8b13ed18.akpm@linux-foundation.org> <49E11FD0.9040403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:54402 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758947AbZDKXKa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Apr 2009 19:10:30 -0400
In-Reply-To: <49E11FD0.9040403@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux.kernel" <linux-kernel@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

On 04/12/2009 12:55 AM, Niel Lambrechts wrote:
> Could it be related to this commit?
>
> commit 0e501834f8c2ba7de2a56e332d346dcf4ac0b593
> Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Date:   Sat Apr 4 04:25:53 2009 +0000
>
>     thinkpad-acpi: rework brightness support
>
>     Refactor and redesign the brightness control backend...
>   
Okay, please bear with me (I'm a git novice) but when I did

'git revert 0e501834f8c2ba7de2a56e332d346dcf4ac0b593'

and recompiled I was still unable to control the brightness with the
hotkeys...

Niel


