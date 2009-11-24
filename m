From: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: Vortex86SX: only works with irqpoll
Date: Tue, 24 Nov 2009 09:29:25 -0200
Message-ID: <be7a9f3d0911240329r50ddb22dvd933f01d296295c1@mail.gmail.com>
References: <be7a9f3d0911191311p45d4438bg84d55234eacdd320@mail.gmail.com>
	 <20091123134002.bac1e664.akpm@linux-foundation.org>
	 <4B0B1B62.2030302@gmail.com>
	 <be7a9f3d0911231601p4dcfa519q4d1504a8ee37fdad@mail.gmail.com>
	 <4B0B36F0.30109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:39304 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756205AbZKXL3U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Nov 2009 06:29:20 -0500
In-Reply-To: <4B0B36F0.30109@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hello Robert,

On Mon, Nov 23, 2009 at 11:29 PM, Robert Hancock <hancockrwd@gmail.com> wrote:
> Looking at the BIOS manual on their web site:
>
> ftp://download@ftp.dmp.com.tw/vortex86sx/Vortex86SX_BIOS_Manual.pdf
>
> you can try toggling a few of the options: Try switching OnBoard IDE Operate
> Mode between Legacy Mode and Native Mode. If the kernel and the actual
> device disagree here, that could cause IRQ delivery problems. You can also
> try playing with the "Plug & Play OS" setting.

The machine with me has no "OnBoard IDE Operate Mode" option. "Plug &
Play OS" has been tried with "Yes" and "No".

If the kernel and the actual device disagree, could it  also "break"
the ethernet adaptor? This also doesn't work.

-- 
Otavio Salvador                  O.S. Systems
E-mail: otavio@ossystems.com.br  http://www.ossystems.com.br
Mobile: +55 53 9981-7854         http://projetos.ossystems.com.br
