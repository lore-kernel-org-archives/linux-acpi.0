From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: New SmartBattery DSDT-based controller
Date: Sat, 29 Jan 2005 18:45:38 -0500
Message-ID: <41FC2022.2080804@bartol.udel.edu>
References: <41FBDDE2.1050403@bartol.udel.edu> <m27jlvx3i3.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m27jlvx3i3.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Johan Vromans wrote:
> Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org> writes:
> 
> 
>>Acer TravelMate 4001wlmi:
>>http://shayol.bartol.udel.edu/~rhdt/download/tm4001wlmi-sbs-cm.aml
>>(this is based on the *fixed* DSDT posted on Johan Vromans' web page,
>>for his 1.5Ghz Centrino machine; I've not been able to test it, but I
>>expect it to work).
> 
> 
> As far as I can see, works like a charm.
> Compiling the DSDT gives a couple of warnings, but these seem harmless.
> For an unknown reason I can't currently access the i2c devices, so I
> cannot compare the output of both methods.

The warnings are nothing to worry about; the methods defined by the 
SMBus Control Method Interface have reserved names, in that they begin 
with underscores, and that causes the compiler to whine a little.

The i2c device stuff doesn't work simultaneously because the original 
SMBus controller section in the DSDT has been commented out. I figured 
that there wouldn't be much use for it, but you can try uncommenting it 
in the source code and recompiling. Look for the device named "SMBS".

> 
> Good job, Richard!

Glad it works! I'm still trying to get the alarm polling working 
properly, this looks on the whole to be a good solution.

cheers,

Rich


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
