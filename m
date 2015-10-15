From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 1/2] ACPI / tables: simplify acpi_parse_entries
Date: Thu, 15 Oct 2015 16:44:41 +0100
Message-ID: <561FC9E9.20507@arm.com>
References: <1442408287-10410-1-git-send-email-sudeep.holla@arm.com>
 <1443712312-9176-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443712312-9176-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

On 01/10/15 16:11, Sudeep Holla wrote:
> acpi_parse_entries passes the table end pointer to the sub-table entry
> handler. acpi_parse_entries itself could validate the end of an entry
> against the table end using the length in the sub-table entry.
>
> This patch adds the validation of the sub-table entry end using the
> length field.This will help to eliminate the need to pass the table end
> to the handlers.
>
> It also moves the check for zero length entry early so that execution of
> the handler can be avoided.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Now that Al's MADT is queued, can you consider applying these ?

-- 
Regards,
Sudeep
