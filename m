From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: [ibm-acpi-devel] CONFIG_IBM_BAY
Date: Thu, 15 Mar 2007 16:31:32 -0400
Message-ID: <41840b750703151331j115df8fcu9cc1084203903c26@mail.gmail.com>
References: <11736588493609-git-send-email-hmh@hmh.eng.br>
	 <20070315031015.GA6292@khazad-dum.debian.net>
	 <20070315031251.GB6292@khazad-dum.debian.net>
	 <200703150206.05811.lenb@kernel.org>
	 <20070315133900.GC26862@khazad-dum.debian.net>
	 <20070315080644.c73db24a.kristen.c.accardi@intel.com>
	 <20070315175505.GB6596@khazad-dum.debian.net>
	 <20070315110156.09e80b99.kristen.c.accardi@intel.com>
	 <20070315193123.GB14394@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.176]:12719 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbXCOUbf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Mar 2007 16:31:35 -0400
Received: by ik-out-1112.google.com with SMTP id c21so258561ika
        for <linux-acpi@vger.kernel.org>; Thu, 15 Mar 2007 13:31:34 -0700 (PDT)
In-Reply-To: <20070315193123.GB14394@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Len Brown <lenb@kernel.org>

On 3/15/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> 2. It will do the right thing on plug and unplug.  This means telling the
> rest of the kernel to disable the device in the bay, for example.  Right now
> we shutdown one end of the PATA/SATA link on ThinkPads eletrically, and
> leave libata to scream blood murder until it disables its end due to too
> many retries, for example;

I'm not sure which stage of the unplug  you're referring to, but after
a "lever released" event on ThinkPads there must remain a way for
userspace code to run before the kernel does anything irreversible to
the drivers or hardware (e.g., in order to try unmounting filesystems
and, if that failed, tell the user to not pull the lever). The
two-stage mechanical eject mechanisms on ThinkPad is pretty useful in
this respect.

  Shem
