From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ACPI trouble in SHG 4000 notebook
Date: Mon, 10 Oct 2005 12:38:09 +0200
Message-ID: <434A4491.7010308@suse.de>
References: <62093.84.48.53.145.1128599474.squirrel@84.48.53.145>       <43455C54.5040309@suse.de>    <60067.84.48.56.10.1128651400.squirrel@84.48.56.10>    <43465ED1.2090505@suse.de> <59137.84.48.53.17.1128726076.squirrel@84.48.53.17>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <59137.84.48.53.17.1128726076.squirrel-Eqzx7D6fnAmBstAda7auyg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: foolish-joSiycWv2dg+3ClZCHpbBg@public.gmane.org
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

foolish-joSiycWv2dg+3ClZCHpbBg@public.gmane.org wrote:
> 
>> foolish-joSiycWv2dg+3ClZCHpbBg@public.gmane.org wrote:
>>> Here's the acpidmp output. Thanks for taking interest.
>> Do you know how to overwrite your DSDT?
>> If not, I can tell you how to do it for SUSE Linux or how you can
>> integrate it
>> into the kernel (you need to recompile your kernel for that).
>> Otherwise you have to reask at acpi-devel.
>>
>> I attached the changes I have made to your DSDT and the compiled DSDT
>> (DSDT.aml)
>> which you can append to your initrd (if your distribution allows that).
>> I hope that fixes this issue.
>> Tell me if you have problems.
 >
> Thanks so much for this. I'm using Fedora Core 4 and I will need to
> recompile my kernel with the neccessary patches to do this. I'm not quite
> sure how though. If you could I would greatly appriciate instructions with
> as much detail as possible, Thanks again for your help.
> 
Posting on acpi-devel again, others might also want to know this ...
Maybe it is also possible to attach the DSDT to the initrd for Fedora kernels. 
If yes, hopefully someone will tell you now, or you will have a lot more work to do.

Hmmm, I don't know how you get the default config of your fedora kernel ...
Once you have your kernel sources installed in /usr/src/linux and your default 
configuration in .config do:

Reget the DSDT (you have to compile it in another way than I did (for initrd 
inclusion)):

acpidmp >/tmp/acpidmp
acpixtract dsdt /tmp/acpidmp >/tmp/dsdt
iasl -d /tmp/dsdt

Patch your DSDT with my changes and recompile it for kernel inclusion:

cd /tmp
patch -i acpi_fix.diff
iasl -tc dsdt.dsl
cp dsdt.hex /etc           (maybe it's named similar but should end with hex)

Include the modified DSDT into your kernel:

cd /usr/src/linux
make menuconfig       (maybe you need to install some more packages - ncurses..)
Goto menu Powermanagement->ACPI and enable "Include Custom DSDT"
Select the new entry "Custom DSDT Table file to include" and enter the path to 
the previously compiled DSDT (/etc/dsdt.hex or similar).
Compile and install the kernel:
make all;install;modules_install
Not sure whether there are other things to do for Fedora (create an initrd, ...)
Look in /boot directory and adjust your bootloader to load the newly compiled 
kernel.

        Thomas


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
