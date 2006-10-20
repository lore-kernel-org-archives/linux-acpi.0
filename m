From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Subject: Re: speedstep-centrino: ENODEV
Date: Fri, 20 Oct 2006 09:34:15 +0200
Message-ID: <45387BF7.3010302@molgaard.org>
References: <EB12A50964762B4D8111D55B764A8454C1A534@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cicero1.cybercity.dk ([212.242.40.4]:36062 "EHLO
	cicero1.cybercity.dk") by vger.kernel.org with ESMTP
	id S2992545AbWJTHeW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Oct 2006 03:34:22 -0400
In-Reply-To: <EB12A50964762B4D8111D55B764A8454C1A534@scsmsx413.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Pallipadi, Venkatesh wrote:
> Make sure you have properly configured speedstep-centrino (You should select X86_SPEEDSTEP_CENTRINO_ACPI along with X86_SPEEDSTEP_CENTRINO).

I have enabled all options in the make menuconfig menu under cpufreq 
(except the one marked deprecated). Still no go :-(

/sunem
