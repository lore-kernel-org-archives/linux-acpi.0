From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Generic battery interface
Date: Fri, 28 Jul 2006 17:13:57 +0300
Message-ID: <41840b750607280713x2f779ba1nbbb59811904b61b6@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB601168B34@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:41791 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161172AbWG1OOB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Jul 2006 10:14:01 -0400
Received: by ug-out-1314.google.com with SMTP id m3so779496ugc
        for <linux-acpi@vger.kernel.org>; Fri, 28 Jul 2006 07:13:59 -0700 (PDT)
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB601168B34@hdsmsx411.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

On 7/28/06, Brown, Len <len.brown@intel.com> wrote:
> good for shell scripts, not clear it is better for C programs
> that have to open a bunch of files by name.

> Wonderful, but isn't the key here how simple it is for HAL
> or X to understand and use the kernel API rather than the
> developers of the kernel driver that implements the API?

For a C program it's just open()+fscanf()+close(). You can easily wrap
it up in a 10-line function, and that's probably what HAL and friends
are already doing.

Anyway, I was just pointing out a practical advantage. The decision
about sysfs's textual interface has already been taken, for better or
worse, and I don't think it's good to invent a totally new interface
unless there's a strong technical reason why the sysfs model is
inappropriate for this task.

  Shem
