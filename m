From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: Incorrect ACPI tables walk in acpi_tables_sysfs_init
Date: Thu, 21 Nov 2013 14:27:22 +0100
Message-ID: <10117757.kh27mk2tn6@vostro.rjw.lan>
References: <87bo1e839w.fsf@tldlab276.tl.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87bo1e839w.fsf@tldlab276.tl.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Compostella <jeremy.compostella@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jeremy Compostella <jeremy.compostella@gmail.com>, "Gross, Mark" <mark.gross@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thursday, November 21, 2013 11:20:27 AM Jeremy Compostella wrote:
> Date: Thu, 21 Nov 2013 11:20:23 +0100
> Message-ID: <87d2lu83a0.fsf@tldlab276.tl.intel.com>
> MIME-Version: 1.0
> Content-Type: text/plain
> --text follows this line--
> Hi,
> 
> When executing on a ACPI Hardware reduced hardware, all the ACPI tables are not
> exposed in sysfs due to the fact that FACS is silently ignored by the kernel in
> ACPI hardware reduced and, moreover, the acpi_tables_sysfs_init ACPI table walk
> is buggy and stop too soon.
> 
> The acpi_tables_sysfs_init function should to rely on the appropriate
> acpi_status return values to decide or not to stop the iteration.  This way,
> when running on a ACPI Reduced Harware environment where the FACS table is
> silently ignored by the kernel or some ACPI table are not correctly memory
> mapped or have a bad checksum it would not stop the iteration.
> 
> Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>

Since this is a fix, I've modified the subject and changelog slightly and
queued up the patch for the next ACPI pull request (next week).

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
