From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] doc: acpi: fix path for acpidbg tool
Date: Mon, 11 Mar 2019 12:58:46 +0100
Message-ID: <2066889.Es8ADf5CTK@aspire.rjw.lan>
References: <1551437591-11022-1-git-send-email-f.suligoi@asem.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551437591-11022-1-git-send-email-f.suligoi@asem.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Flavio Suligoi <f.suligoi@asem.it>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday, March 1, 2019 11:53:11 AM CET Flavio Suligoi wrote:
> The file:
> 
> Documentation/acpi/aml-debugger.txt
> 
> reports an obsolete path for the acpidbg tool.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  Documentation/acpi/aml-debugger.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/acpi/aml-debugger.txt b/Documentation/acpi/aml-debugger.txt
> index e851cc5..75ebeb6 100644
> --- a/Documentation/acpi/aml-debugger.txt
> +++ b/Documentation/acpi/aml-debugger.txt
> @@ -23,7 +23,7 @@ kernel.
>  
>     The resultant userspace tool binary is then located at:
>  
> -     tools/acpi/power/acpi/acpidbg/acpidbg
> +     tools/power/acpi/acpidbg
>  
>     It can be installed to system directories by running "make install" (as a
>     sufficiently privileged user).
> @@ -35,7 +35,7 @@ kernel.
>  
>     # mount -t debugfs none /sys/kernel/debug
>     # modprobe acpi_dbg
> -   # tools/acpi/power/acpi/acpidbg/acpidbg
> +   # tools/power/acpi/acpidbg
>  
>     That spawns the interactive AML debugger environment where you can execute
>     debugger commands.
> 

Applied, thanks!
