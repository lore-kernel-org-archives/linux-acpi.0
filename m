From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Wed, 19 Jan 2005 22:03:06 -0500
Message-ID: <41EF1F6A.5000807@bartol.udel.edu>
References: <41E81C2C.8010809@bartol.udel.edu>	<1105747983.7368.3.camel@tyrosine>	<47e0449d05011419037877f931@mail.gmail.com> <m2fz13x8mw.fsf@phoenix.squirrel.nl> <41EA2C1D.3030909@bartol.udel.edu> <41EC7C7D.1070003@bartol.udel.edu> <41EC9316.80109@bartol.udel.edu> <41EDE2EA.7090404@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41EDE2EA.7090404-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Tonight's build:

http://shayol.bartol.udel.edu/~rhdt/download/acpi_sbs-20050120.tar.gz

...only has one modification (apart from fixing a typo in my name, 
thanks to Olaf Jansen-OIlliges!). The 'present rate' field in the 
legacy-interface /proc/acpi/battery/*/state file is supposed to show the 
present discharge/charge rate in either mA or mW, depending on the 
capacity_mode used. However, I've just been using the current (in mA) 
returned by the Smart Battery System, which is clearly incorrect when 
capacity_mode=2 (mW) is selected.

I've fixed this in a rather cunning way. The SBS is more sophisticated 
than normal control-method batteries, in that individual batteries can 
report their time to empty or full (applications reporting on CM 
batteries have to calculate these times from the last full capacity and 
discharge/charge rates). What I've done in the latest release is to 
calculate what value of the 'present rate' field will produce the 
correct time to empty or full when combined with the last full capacity. 
The upshot is, not only does the 'present rate' field now give sensible 
values when capacity_mode=2, but also the times reported by applications 
using the legacy interface will be direct reflections of the proper SBS 
times.

The SBS driver seems to be working reasonably well now -- there are no 
outstanding bugs. My next task is to work out how best to aim for kernel 
integration, and to figure out how to set up event handling. Don't 
expect the pace of development to be as fast as the past few days -- I 
need sleep like the rest of you!

cheers,

Rich


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
