From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] acpi-video: Filter the BCL table for duplicate brightness
 values
Date: Fri, 14 Feb 2014 10:05:02 +0100
Message-ID: <52FDDC3E.1070103@redhat.com>
References: <1392305571-4895-1-git-send-email-hdegoede@redhat.com> <52FD6E6A.5090504@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48145 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449AbaBNJFP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Feb 2014 04:05:15 -0500
In-Reply-To: <52FD6E6A.5090504@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

Hi,

On 02/14/2014 02:16 AM, Aaron Lu wrote:
> On 02/13/2014 11:32 PM, Hans de Goede wrote:
>> Some devices have duplicate entries in there brightness levels table, ie
>> on my Dell Latitude E6430 the table looks like this:
> 
> For reference's purpose, can you please file a bug in kernel bugzilla
> under the ACPI/Power-Video category and attach the acpidump there? Thanks.

Done:

https://bugzilla.kernel.org/show_bug.cgi?id=70571

Regards,

Hans
