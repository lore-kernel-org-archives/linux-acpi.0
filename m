From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 3/3] ACPICA: Remove use of __DATE__ macro
Date: Mon, 05 Jan 2015 11:26:52 +0100
Message-ID: <87oaqdy13n.fsf@rasmusvillemoes.dk>
References: <1418381488-25123-1-git-send-email-linux@rasmusvillemoes.dk>
	<1418381488-25123-3-git-send-email-linux@rasmusvillemoes.dk>
	<1AE640813FDE7649BE1B193DEA596E88026AACD9@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88026AACD9@SHSMSX101.ccr.corp.intel.com>
	(Lv Zheng's message of "Mon, 5 Jan 2015 08:47:43 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 05 2015, "Zheng, Lv" <lv.zheng@intel.com> wrote:

> Hi,
>
>> From: Rasmus Villemoes [mailto:linux@rasmusvillemoes.dk]
>> Sent: Friday, December 12, 2014 6:51 PM
>> To: Zheng, Lv
>> Cc: Rasmus Villemoes; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org
>> Subject: [PATCH 3/3] ACPICA: Remove use of __DATE__ macro
>> 
>> The macro __DATE__ and friends is not allowed in the kernel. Also,
>> including the build time in output doesn't seem to provide any value.
>> 
>
> Could you confirm that it is not useful even for the user tools?
> Please perform the following commands in the kernel source tree
> 1. stay in tools folder
> 2. type "make acpi"
> 3. type "./power/acpi/acpidump -v"
>

Yeah, it's part of the output, but for what reason? What can userspace
possibly use that information for? I can see some utility in printing a
version number, since that may tell something about the features
present or absent. The compilation date, on the other hand, seems
completely useless. Different distros may ship different versions which
happened to be compiled on the same day, or older versions compiled later.

Note that -Werror=date-time was added to the kernel's default build
flags in fe7c36c7bde12. It doesn't currently show because tools/ uses
its own flags, and the ACPI_COMMON_SIGNON macro is not used within the
kernel. 

Rasmus
