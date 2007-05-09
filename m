From: "Paulo J. Matos" <pocm@soton.ac.uk>
Subject: ACPI problem in Kernel 2.6.20
Date: Wed, 9 May 2007 14:50:17 +0100
Message-ID: <11b141710705090650l482dff24r529a617563e17663@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:19728 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbXEINuS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 May 2007 09:50:18 -0400
Received: by wx-out-0506.google.com with SMTP id h31so186630wxd
        for <linux-acpi@vger.kernel.org>; Wed, 09 May 2007 06:50:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

Hello all,

I've been installing gentoo on a HP Compaq tc4200 tablet PC and things
seem to work fine except ACPI which (through kacpid) eats up my
processor constantly by 100%. This is definitely a problem since
passing noacpi to the kernel (although it solves the kacpid cpu
hunger) removes the possibility of havin battery, fan, cpu temp, etc.

Any ideas on how to solve something like this?

Cheers,

Paulo Matos

-- 
Paulo Jorge Matos - pocm at soton.ac.uk
http://www.personal.soton.ac.uk/pocm
PhD Student @ ECS
University of Southampton, UK
