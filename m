From: Jeremie Tamburini <jeremie.tamburini@gmail.com>
Subject: Re: BUG REPORT backlight acpi: Brightness shortcuts don't work on
 Fujitsu
Date: Wed, 02 Jul 2014 11:55:51 +0200
Message-ID: <53B3D727.2060701@gmail.com>
References: <538D7845.9010305@gmail.com> <538D80C4.5080901@intel.com> <538D91B4.7050209@gmail.com> <538E85C7.5030809@intel.com> <53AC499A.1000506@gmail.com> <53B0BE4E.2070500@intel.com> <53B2B1DE.8090709@gmail.com> <53B3C7E8.1060001@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35395 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaGBJzz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jul 2014 05:55:55 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so11149109wgh.16
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jul 2014 02:55:54 -0700 (PDT)
In-Reply-To: <53B3C7E8.1060001@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org

Il 02/07/2014 10:50, Aaron Lu ha scritto:
> I think you will need at least:
>
> commit fbc9fe1b4f222a7c575e3bd8e9defe59c6190a04
> Author: Aaron Lu <aaron.lu@intel.com>
> Date:   Fri Oct 11 21:27:45 2013 +0800
>
>      ACPI / video: Do not register backlight if win8 and native interface exists
>
> commit 0e9f81d3b7cd0649a3bc437391b6a0650f98f844
> Author: Aaron Lu <aaron.lu@intel.com>
> Date:   Tue Feb 18 13:54:20 2014 +0800
>
>      ACPI / video: Add systems that should favour native backlight interface
>
> commit 751109aad5834375ca9ed0dcfcd85a00cbf872b5
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Thu Jun 5 22:47:35 2014 +0200
>
>      ACPI / video: Change the default for video.use_native_backlight to 1
>
> Maybe others, you will need to figure them out.

OK, thank you very much!
Jeremie
