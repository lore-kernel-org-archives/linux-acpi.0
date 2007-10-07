From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Fix Oops in toshiba_acpi error return path
Date: Sun, 7 Oct 2007 14:54:00 -0400
Message-ID: <200710071454.01010.dmitry.torokhov@gmail.com>
References: <200710072053.02865.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:63451 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbXJGSzf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Oct 2007 14:55:35 -0400
Received: by rv-out-0910.google.com with SMTP id k20so561187rvb
        for <linux-acpi@vger.kernel.org>; Sun, 07 Oct 2007 11:55:35 -0700 (PDT)
In-Reply-To: <200710072053.02865.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: toshiba_acpi@memebeam.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 07 October 2007, Andrey Borzenkov wrote:
> This fixes oops when registering backlight device fails. Attached as I still 
> cannot convince kmail to not mangle long lines ...
> 
> -andrey
> 

Re: kmail - it usually behaves well with the patches as long as
you turn off word wrapping and use "Insert file..." to insert
them.

-- 
Dmitry
